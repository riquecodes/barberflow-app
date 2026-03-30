using BarberFlow.API.Models;

namespace BarberFlow.API.Repositories;

public interface IAppointmentRepository
{
    Task<bool> ExistsAsync(DateTime date, TimeOnly time);

    Task CreateAsync(AppointmentModel appointment);

    Task<IEnumerable<AppointmentModel>> GetByDateAsync(DateTime date);

    Task<AppointmentModel?> GetByIdAsync(int id);

    Task CancelAsync(int id);
}
