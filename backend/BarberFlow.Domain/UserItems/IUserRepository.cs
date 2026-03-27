namespace BarberFlow.Domain.UserItems;

public interface IUserRepository
{
    Task<User> GetCompleteUserByEmailAsync(string email);
}
