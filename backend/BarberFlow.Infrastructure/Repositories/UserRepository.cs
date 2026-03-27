using BarberFlow.Domain.UserItems;

namespace BarberFlow.Infrastructure.Repositories;

public class UserRepository : IUserRepository
{
    public async Task<User> GetCompleteUserByEmailAsync(string email)
    {
        string sql = @"
            SELECT
                id_user"
    }
}
