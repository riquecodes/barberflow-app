using BarberFlow.API.Models;

namespace BarberFlow.API.Services
{
    public interface IAccountService
    {
        Task<AccountModel?> GetAccountById(int accountId);
        Task<IEnumerable<AccountModel>> GetAccountsByUserId(int userId);
        Task<decimal> GetBalanceById(int id);
        Task<AccountModel> CreateAccount(AccountModel account);
    }
}