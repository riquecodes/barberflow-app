using BarberFlow.API.Context;
using BarberFlow.API.Models;
using Microsoft.EntityFrameworkCore;

namespace BarberFlow.API.Repositories;

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

    public async Task<ServiceModel> UpdateService(ServiceModel service)
    {
        _context.Services.Update(service);
        await _context.SaveChangesAsync();
        return service;
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
