using BarberFlow.API.Models;

namespace BarberFlow.API.Repositories;

public interface IAppointmentRepository
{
    Task<bool> ExistsAsync(DateOnly date, TimeOnly time);

    Task CreateAsync(AppointmentModel appointment);

    Task<IEnumerable<AppointmentModel>> GetByDateAsync(DateOnly date);

    Task<AppointmentModel?> GetByIdAsync(int id);

    Task CancelAsync(int id);
}
