using BarberFlow.API.Models;
using System.Threading.Tasks;

namespace BarberFlow.API.Repositories
{
    public interface IAccountRepository
    {
        Task<ServiceModel?> GetAccountById(int id);
        Task<IEnumerable<ServiceModel>> GetAccountsByUserId(int userId);
        Task<decimal> GetBalanceById(int id);
        Task<ServiceModel> CreateAccount(ServiceModel account);
    }
}
