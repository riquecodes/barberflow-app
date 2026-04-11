using BarberFlow.API.Models;

namespace BarberFlow.API.Repositories;

public interface IServicesRepository
{
    Task<ServiceModel?> GetServiceById(int serviceId);

    Task<IEnumerable<ServiceModel>> GetAllServices();

    Task<ServiceModel> CreateService(ServiceModel service);

    Task<ServiceModel?> UpdateService(int serviceId, ServiceModel service);

    Task<bool> DeleteService(int serviceId);
}
