namespace BarberFlow.Domain.LoginItems;

public interface IUserRepository
{
    Task<string> GetUserByEmailAsync(string email, string password);
}
