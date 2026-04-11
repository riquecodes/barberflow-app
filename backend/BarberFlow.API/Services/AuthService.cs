using BarberFlow.API.Controllers;
using BarberFlow.API.Models;
using BarberFlow.API.Repositories;
using BarberFlow.API.Utils;

namespace BarberFlow.API.Services;

public class AuthService(IUserRepository userRepository, IConfiguration configuration, ILogger<AuthController> logger)
{
    private readonly IUserRepository _userRepository = userRepository;
    private readonly IConfiguration _configuration = configuration;
    private readonly ILogger<AuthController> _logger = logger;

    public async Task<UserResponseDTO> Login(LoginDTO loginDTO)
    {
        var user = await _userRepository.GetFullUserByEmail(loginDTO.Email);

        if (user is null)
        {
            _logger.LogWarning("Login failed for Email {Email}: user not found", loginDTO.Email);
            throw new UnauthorizedAccessException("Email ou Senha incorretos!");
        }
        
        if (!SecurityUtils.VerifyPassword(loginDTO.Password, user.PasswordHash))
        {
            _logger.LogWarning("Login failed for Email {Email}: incorrect password", loginDTO.Email);
            throw new UnauthorizedAccessException("Email ou Senha incorretos!");
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
            _logger.LogWarning("Register failed for Email {Email}:  Email already exists", existingUser.Email);
            throw new ArgumentException("Já existe uma conta com esse Email. Faça Login.");
        }

        ValidateRegisterDTO(userRegister);

        SecurityUtils.ValidatePasswordStrength(userRegister.Password);

        var passHash = SecurityUtils.CreatePasswordHash(userRegister.Password);

        var newUser = new UserModel
        {
            Name = userRegister.Name,
            Email = userRegister.Email,
            Celphone = userRegister.Celphone,
            PasswordHash = passHash,
            Role = userRegister.Role
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
            throw new KeyNotFoundException("Usuário não encontrado!");
        }

        if (!SecurityUtils.VerifyPassword(currentPassword, user.PasswordHash))
        {
            _logger.LogWarning("Change Password attempt failed for ID {id}: incorrect current password", userId);
            throw new UnauthorizedAccessException("Senha atual está incorreta!");
        }

        SecurityUtils.ValidatePasswordStrength(newPassword);

        user.PasswordHash = SecurityUtils.CreatePasswordHash(newPassword);

        await _userRepository.UpdateUser(user.Id, user);
    }

    private static void ValidateRegisterDTO(RegisterDTO userRegister)
    {
        if (string.IsNullOrEmpty(userRegister.Name)
            || string.IsNullOrEmpty(userRegister.Email)
            || string.IsNullOrEmpty(userRegister.Password))
        {
            throw new ArgumentException("Nome e Email são obrigatórios!");
        }
    }
}
