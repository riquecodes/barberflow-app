using BarberFlow.API.Context;
using BarberFlow.API.Models.Appointment;
using BarberFlow.API.Repositories.Appointment;
using Microsoft.EntityFrameworkCore;

namespace BarberFlow.API.Services;

public class AppointmentService(AppDbContext context, IAppointmentRepository repository)
{
    private readonly AppDbContext _context = context;
    private readonly IAppointmentRepository _repository = repository;

    public async Task<IEnumerable<TimeOnly>> GetAvailableTimes(DateOnly date)
    {
        var allTimes = await _context.TimeSlots
            .Select(t => t.Time)
            .ToListAsync();

        var busyTimes = await _context.Appointments
            .Where(a => a.Date == date && !a.IsCanceled)
            .Select(a => a.Time)
            .ToListAsync();

        var available = allTimes
            .Where(t => !busyTimes.Contains(t))
            .OrderBy(t => t);

        return available;
    }

    public async Task<IEnumerable<AppointmentModelDTO?>> GetMyAppointments(int userId)
    {
        var myAppointments = await _repository.GetMyAppointmentsAsync(userId);

        if (myAppointments is null)
            return [];

        return myAppointments;
    }

    public async Task Create(int userId, int serviceId, DateOnly date, TimeOnly time)
    {
        var exists = await _repository.ExistsAsync(date, time);

        if (exists)
            throw new ArgumentException("Horário já está ocupado");

        var appointment = new AppointmentModel
        {
            UserId = userId,
            ServiceId = serviceId,
            Date = date,
            Time = time,
            IsCanceled = false
        };

        await _repository.CreateAsync(appointment);
    }

    public async Task Cancel(int id)
    {
        await _repository.CancelAsync(id);
    }
}
