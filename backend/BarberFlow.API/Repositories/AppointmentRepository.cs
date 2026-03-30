using BarberFlow.API.Context;
using BarberFlow.API.Models;
using Microsoft.EntityFrameworkCore;

namespace BarberFlow.API.Repositories;

public class AppointmentRepository(AppDbContext context) : IAppointmentRepository
{
    private readonly AppDbContext _context = context;

    public async Task<bool> ExistsAsync(DateTime date, TimeOnly time)
    {
        return await _context.Appointments
            .AnyAsync(a => a.Date.Date == date.Date
                        && a.Time == time
                        && !a.IsCanceled);
    }

    public async Task CreateAsync(AppointmentModel appointment)
    {
        await _context.Appointments.AddAsync(appointment);
        await _context.SaveChangesAsync();
    }

    public async Task<IEnumerable<AppointmentModel>> GetByDateAsync(DateTime date)
    {
        return await _context.Appointments
            .Include(a => a.User)
            .Include(a => a.Service)
            .Where(a => a.Date.Date == date.Date)
            .ToListAsync();
    }

    public async Task<AppointmentModel?> GetByIdAsync(int id)
    {
        return await _context.Appointments
            .Include(a => a.User)
            .Include(a => a.Service)
            .FirstOrDefaultAsync(a => a.Id == id);
    }

    public async Task CancelAsync(int id)
    {
        var appointment = await _context.Appointments.FindAsync(id);

        if (appointment is null)
            throw new Exception("Appointment not found");

        appointment.IsCanceled = true;

        await _context.SaveChangesAsync();
    }
}
