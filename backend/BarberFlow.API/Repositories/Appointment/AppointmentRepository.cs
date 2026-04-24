using BarberFlow.API.Context;
using BarberFlow.API.Models.Appointment;
using Microsoft.EntityFrameworkCore;

namespace BarberFlow.API.Repositories.Appointment;

public class AppointmentRepository(AppDbContext context) : IAppointmentRepository
{
    private readonly AppDbContext _context = context;

    public async Task<bool> ExistsAsync(DateOnly date, TimeOnly time)
    {
        return await _context.Appointments
            .AnyAsync(a => a.Date == date
                        && a.Time == time
                        && !a.IsCanceled);
    }

    public async Task<IEnumerable<AppointmentModelDTO?>> GetMyAppointmentsAsync(int userId)
    {
        return await _context.Appointments
            .Where(a => a.UserId == userId && !a.IsCanceled)
            .Include(a => a.Service)
            .Select(a => new AppointmentModelDTO
            {
                Date = a.Date,
                Time = a.Time,
                ServiceName = a.Service.Name,
                ServicePrice = a.Service.Price
            }).ToListAsync();
    }

    public async Task CreateAsync(AppointmentModel appointment)
    {
        await _context.Appointments.AddAsync(appointment);
        await _context.SaveChangesAsync();
    }

    public async Task<IEnumerable<AppointmentModel>> GetByDateAsync(DateOnly date)
    {
        return await _context.Appointments
            .Include(a => a.User)
            .Include(a => a.Service)
            .Where(a => a.Date == date)
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

    public async Task<IEnumerable<AdminAppointmentDTO>> GetAllAppointmentsAsync()
    {
        return await _context.Appointments
            .Include(a => a.User)
            .Include(a => a.Service)
            .Where(a => !a.IsCanceled)
            .OrderBy(a => a.Date).ThenBy(a => a.Time)
            .Select(a => new AdminAppointmentDTO
            {
                Id = a.Id,
                UserName = a.User.Name,
                ServiceName = a.Service.Name ?? "",
                Date = a.Date,
                Time = a.Time,
                ServicePrice = a.Service.Price,
                IsCanceled = a.IsCanceled
            }).ToListAsync();
    }
}
