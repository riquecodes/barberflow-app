using BarberFlow.API.Context;
using BarberFlow.API.Models.Service;
using Microsoft.EntityFrameworkCore;

namespace BarberFlow.API.Repositories.Service;

public class ServicesRepository(AppDbContext context) : IServicesRepository
{
    private readonly AppDbContext _context = context;

    public async Task<ServiceModel?> GetServiceById(int serviceId)
    {
        return await _context.Services.FindAsync(serviceId);
    }

    public async Task<IEnumerable<ServiceModel>> GetAllServices()
    {
        return await _context.Services.ToListAsync();
    }

    public async Task<ServiceModel> CreateService(ServiceModel service)
    {
        await _context.Services.AddAsync(service);
        await _context.SaveChangesAsync();
        return service;
    }

    public async Task<ServiceModel?> UpdateService(int serviceId, ServiceModel service)
    {
        var updatedService = await GetServiceById(serviceId);

        if (updatedService is null)
            return null;

        updatedService.Name = service.Name;
        updatedService.Price = service.Price;
        updatedService.Description = service.Description;
        updatedService.Duration = service.Duration;

        await _context.SaveChangesAsync();
        return updatedService;
    }

    public async Task<bool> DeleteService(int serviceId)
    {
        var service = await _context.Services.FindAsync(serviceId);

        if (service is null)
            return false;

        _context.Services.Remove(service);
        await _context.SaveChangesAsync();

        return true;
    }
}
