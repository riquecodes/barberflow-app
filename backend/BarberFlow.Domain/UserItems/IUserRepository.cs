namespace BarberFlow.Domain.LoginItems;

public interface IUserRepository
{
    Task<Token> GetUserByEmailAsync(string email, string password);
}
