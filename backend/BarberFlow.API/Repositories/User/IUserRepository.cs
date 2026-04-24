using BarberFlow.API.Models.User;

namespace BarberFlow.API.Repositories.User;

public interface IUserRepository
{
    Task<IEnumerable<UserResponseDTO>> GetUsers();
    Task<UserResponseDTO?> GetUserById(int id);
    Task<UserResponseDTO?> GetUserByEmail(string email);
    Task<UserModel?> GetFullUserById(int id);
    Task<UserModel?> GetFullUserByEmail(string email);
    Task<UserModel> CreateUser(UserModel user);
    Task<UserModel?> UpdateUser(int id, UserModel user);
    Task<bool> DeleteUserById(int id);
}
