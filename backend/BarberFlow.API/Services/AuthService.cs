using BarberFlow.API.Controllers;
using BarberFlow.API.Models;
using BarberFlow.API.Repositories;
using BarberFlow.API.Utils;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace BarberFlow.API.Services
{
    public class AuthService(IUserRepository userRepository, IConfiguration configuration, ILogger<AuthController> logger, IAccountRepository accountRepository) : IAuthService
    {
        private readonly IUserRepository _userRepository = userRepository;
        private readonly IAccountRepository _accountRepository = accountRepository;
        private readonly IConfiguration _configuration = configuration;
        private readonly ILogger<AuthController> _logger = logger;

        public async Task<UserResponseDTO> Login(LoginDTO loginDTO)
        {
            var user = await _userRepository.GetFullUserByEmail(loginDTO.Email);

            if (user is null)
            {
                _logger.LogWarning("Login failed for Email {Email}: user not found", loginDTO.Email);
                throw new UnauthorizedAccessException("Invalid Email or Password!");
            }
            
            if (!SecurityUtils.VerifyPassword(loginDTO.Password, user.PasswordHash, user.PasswordSalt)
            {
                _logger.LogWarning("Login failed for CPF {Cpf}: incorrect password", loginDTO.Email);
                throw new UnauthorizedAccessException("Invalid CPF or Password!");
            }

            var authUser = new AuthResponseDTO
            {
                Token = SecurityUtils.GenerateJwtToken(user, _configuration)
            };

            return new UserResponseDTO
            {
                UserId = user.Id,
                Name = user.Name,
                Email = user.Email,
                Celphone = user.Celphone,
                Role = user.Role,
                Auth = authUser
            };
        }

        public async Task<UserResponseDTO> Register(RegisterDTO userRegister)
        {
            var existingUser = await _userRepository.GetUserByEmail(userRegister.Email);

            if (existingUser is not null)
            {
                _logger.LogWarning("Register failed for CPF {Email}:  Email already exists", existingUser.Email);
                throw new ArgumentException("A user with this Email already exists.");
            }

            ValidateRegisterDTO(userRegister);

            SecurityUtils.ValidatePasswordStrength(userRegister.Password);

            SecurityUtils.CreatePasswordHash(userRegister.Password, out byte[] hash, out byte[] salt);

            var newUser = new UserModel
            {
                Name = userRegister.Name,
                Email = userRegister.Email,
                Celphone = userRegister.Celphone,
                PasswordHash = hash,
                //PasswordSalt = salt
            };

            var createdUser = await _userRepository.CreateUser(newUser);

            var authUser = new AuthResponseDTO
            {
                Token = SecurityUtils.GenerateJwtToken(newUser, _configuration)
            };

            return new UserResponseDTO
            {
                UserId = createdUser.Id,
                Name = createdUser.Name,
                Email = createdUser.Email,
                Celphone = createdUser.Celphone,
                Role = createdUser.Role,
                Auth = authUser
            };
        }

        public async Task ChangePassword(int userId, string currentPassword, string newPassword)
        {
            var user = await _userRepository.GetFullUserById(userId);

            if (user is null)
            {
                _logger.LogWarning("Change Password attempt failed for ID {id}: user not found", userId);
                throw new KeyNotFoundException("User not found!");
            }

            if (!SecurityUtils.VerifyPassword(currentPassword, user.PasswordHash, user.PasswordSalt))
            {
                _logger.LogWarning("Change Password attempt failed for ID {id}: incorrect current password", userId);
                throw new UnauthorizedAccessException("Current password is incorrect!");
            }

            SecurityUtils.ValidatePasswordStrength(newPassword);

            using (var hmac = new HMACSHA512())
            {
                user.PasswordSalt = hmac.Key;
                user.PasswordHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(newPassword));
            }

            await _userRepository.UpdateUser(user.Id, user);
        }

        private static void ValidateRegisterDTO(RegisterDTO userRegister)
        {
            if (string.IsNullOrEmpty(userRegister.Name)
                || string.IsNullOrEmpty(userRegister.Email))
            {
                throw new ArgumentException("Name and Email are required fields!");
            }
        }
    }
}
