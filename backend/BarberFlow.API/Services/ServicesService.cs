using BarberFlow.API.Models;
using BarberFlow.API.Repositories;

namespace BarberFlow.API.Services;

public class ServicesService(IServicesRepository serviceRepository)
{
    private readonly IServicesRepository _serviceRepository = serviceRepository;

    public async Task<ServiceModel?> GetServiceById(int id)
    {
        var service = await _serviceRepository.GetServiceById(id);
        return service is null
            ? throw new ArgumentException("Serviço não encontrado.")
            : service;
    }

    public async Task<IEnumerable<ServiceModel>> GetAllServices()
    {
        var services = await _serviceRepository.GetAllServices();
        return services.Any() ? services : [];
    }

    public async Task<ServiceModel> CreateService(ServiceModel service)
    {
        // validação simples
        if (string.IsNullOrWhiteSpace(service.Name))
            throw new ArgumentException("Nome do serviço é obrigatório.");

        if (service.Price <= 0)
            throw new ArgumentException("Preço do serviço tem que ser maior que zero.");

        if (service.Duration <= 0)
            throw new ArgumentException("Duração do serviço tem que ser maior que zero.");

        var createdService = await _serviceRepository.CreateService(service);

        return createdService;
    }

    public async Task<ServiceModel> UpdateService(ServiceModel service)
    {
        var existing = await _serviceRepository.GetServiceById(service.ServiceId);

        if (existing is null)
            throw new ArgumentException("Serviço não encontrado.");

        return await _serviceRepository.UpdateService(service);
    }

    public async Task<bool> DeleteService(int id)
    {
        var existing = await _serviceRepository.GetServiceById(id);

        if (existing is null)
            throw new ArgumentException("Serviço não encontrado.");

        return await _serviceRepository.DeleteService(id);
    }
}
