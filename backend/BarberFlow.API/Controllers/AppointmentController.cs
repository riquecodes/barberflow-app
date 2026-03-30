using BarberFlow.API.Models;
using BarberFlow.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BarberFlow.API.Controllers;

[ApiController]
[Route("barber/agendamento")]
public class AppointmentController(AppointmentService service) : ControllerBase
{
    private readonly AppointmentService _service = service;

    [HttpGet("disponiveis")]
    public async Task<IActionResult> GetAvailable([FromQuery] DateTime date)
    {
        var result = await _service.GetAvailableTimes(date);
        return Ok(result);
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> Create(CreateAppointmentDTO dto)
    {
        await _service.Create(dto.UserId, dto.ServiceId, dto.Date, dto.Time);
        return Ok("Agendamento criado com sucesso");
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Cancel(int id)
    {
        await _service.Cancel(id);
        return Ok("Agendamento cancelado");
    }
}
