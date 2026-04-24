using BarberFlow.API.Models.Auth;
using BarberFlow.API.Models.User;
using BarberFlow.API.Repositories.User;
using BarberFlow.API.Utils;

namespace BarberFlow.API.Services;

public class UserService(IUserRepository userRepository)
{
    private readonly IUserRepository _userRepository = userRepository;

    public async Task<IEnumerable<UserResponseDTO>> GetUsers()
    {
        var users = await _userRepository.GetUsers();

        if (!users.Any())
        { 
            throw new KeyNotFoundException("Nenhum usuário encontrado!");
        }

        return users.OrderBy(u => u.Name);
    }

    public async Task<UserResponseDTO?> GetUserById(int id)
    {
        var user = await _userRepository.GetUserById(id);

        return user is null ? throw new KeyNotFoundException($"Usuário não encontrado!") : user;
    }

    public async Task<UserResponseDTO?> GetUserByEmail(string email)
    {
        var user = await _userRepository.GetUserByEmail(email);

        return user is null ? throw new KeyNotFoundException($"Usuário com o email {email} não encontrado!") : user;
    }

    public async Task<UserModel?> GetFullUserById(int id)
    {
        var user = await _userRepository.GetFullUserById(id);

        return user is null ? throw new KeyNotFoundException($"Usuário não encontrado!") : user;
    }

    public async Task<UserResponseDTO> CreateUser(RegisterDTO userRegister)
    {
        await ValidateRegisterDTO(userRegister);

        var senhaHash = SecurityUtils.CreatePasswordHash(userRegister.Password);

        var newUser = new UserModel
        {
            Name = userRegister.Name,
            Celphone = userRegister.Celphone,
            Email = userRegister.Email,
            PasswordHash = senhaHash,
            Role = userRegister.Role,
        };

        var createdUser = await _userRepository.CreateUser(newUser);

        return new UserResponseDTO 
        { 
            UserId = createdUser.Id,
            Name = createdUser.Name,
            Email = createdUser.Email,
            Celphone = createdUser.Celphone,
            Role = createdUser.Role
        };
    }
    
    public async Task<UserResponseDTO?> UpdateUser(int id, UserModelDTO userDTO)
    {

        var userToUpdate = await _userRepository.GetFullUserById(id) ?? throw new KeyNotFoundException($"Usuário não encontrado!");
        
        userToUpdate.Name = userDTO.Name;
        userToUpdate.Celphone = userDTO.Celphone;
        userToUpdate.Email = userDTO.Email;
        userToUpdate.Role = userDTO.Role;

        await _userRepository.UpdateUser(id, userToUpdate);

        var updatedResponse = new UserResponseDTO
        {
            UserId = id,
            Name = userToUpdate.Name,
            Celphone = userToUpdate.Celphone,
            Email = userToUpdate.Email,
            Role = userToUpdate.Role
        };

        ValidateUserDTO(updatedResponse);

        return updatedResponse;
    }

    public async Task<bool> DeleteUserById(int id)
    {
        var userToDelete = await _userRepository.GetFullUserById(id);

        if (userToDelete is null)
        {
            throw new KeyNotFoundException($"Usuário não encontrado!");
        }

        return await _userRepository.DeleteUserById(id);

    }

    private async Task ValidateRegisterDTO(RegisterDTO userRegister)
    {
        if (string.IsNullOrEmpty(userRegister.Name)
            || string.IsNullOrEmpty(userRegister.Email)
            || string.IsNullOrEmpty(userRegister.Password))
        {
            throw new ArgumentException("Nome, Email e Senha são campos obrigatórios!");
        }

        var userExists = await _userRepository.GetUserByEmail(userRegister.Email);

        if (userExists is not null)
        {
            throw new ArgumentException("Já existe um usuário com esse Email. Faça Login!");
        }
    }

    private void ValidateUserDTO(UserResponseDTO userDTO)
    {
        if (string.IsNullOrEmpty(userDTO.Name)
            || string.IsNullOrEmpty(userDTO.Email))
        {
            throw new ArgumentException("Nome e Email são obrigatórios!");
        }
    }
}
