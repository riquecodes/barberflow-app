using BarberFlow.API.Models.Service;
using BarberFlow.API.Repositories.Service;

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

    public async Task<ServiceModel> CreateService(ServiceModelDTO service)
    {
        // validação simples
        if (string.IsNullOrWhiteSpace(service.Name))
            throw new ArgumentException("Nome do serviço é obrigatório.");

        if (service.Price <= 0)
            throw new ArgumentException("Preço do serviço tem que ser maior que zero.");

        if (service.Duration <= 0)
            throw new ArgumentException("Duração do serviço tem que ser maior que zero.");

        var newService = new ServiceModel
        {
            Name = service.Name,
            Description = service.Description,
            Price = service.Price,
            Duration = service.Duration,
        };

        var createdService = await _serviceRepository.CreateService(newService);

        return createdService;
    }

    public async Task<ServiceModel> UpdateService(int serviceId, ServiceModelDTO service)
    {
        var serviceToUpdate = await _serviceRepository.GetServiceById(serviceId);

        if (serviceToUpdate is null)
            throw new ArgumentException("Serviço não encontrado.");

        serviceToUpdate.Name = service.Name;
        serviceToUpdate.Description = service.Description;
        serviceToUpdate.Price = service.Price;
        serviceToUpdate.Duration = service.Duration;

        var serviceUpdated = await _serviceRepository.UpdateService(serviceId, serviceToUpdate);

        return serviceUpdated is null ? throw new ArgumentException("Serviço não encontrado.") : serviceUpdated;
    }

    public async Task<bool> DeleteService(int id)
    {
        var existing = await _serviceRepository.GetServiceById(id);

        return existing is null ? throw new ArgumentException("Serviço não encontrado.") : await _serviceRepository.DeleteService(id);
    }
}
