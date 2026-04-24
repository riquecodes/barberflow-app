using System.Security.Claims;
using BarberFlow.API.Models.Appointment;
using BarberFlow.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BarberFlow.API.Controllers;

[ApiController]
[Route("barber/agendamentos")]
public class AppointmentController(AppointmentService service) : ControllerBase
{
    private readonly AppointmentService _service = service;

    [HttpGet("disponiveis")]
    [Authorize]
    public async Task<IActionResult> GetAvailable([FromQuery] string date)
    {
        var parsedDate = DateOnly.ParseExact(date, "yyyy-MM-dd");

        var result = await _service.GetAvailableTimes(parsedDate);
        return Ok(result);
    }

    [HttpGet("meus")]
    [Authorize]
    public async Task<IActionResult> GetMyAppointments()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        var appointments = await _service.GetMyAppointments(int.Parse(userId));

        return Ok(appointments);
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> Create(CreateAppointmentDTO dto)
    {
        await _service.Create(dto.UserId, dto.ServiceId, dto.Date, dto.Time);
        return Ok("Agendamento criado com sucesso");
    }

    [HttpDelete("{id}")]
    [Authorize]
    public async Task<IActionResult> Cancel(int id)
    {
        await _service.Cancel(id);
        return Ok("Agendamento cancelado");
    }

    [HttpGet("admin")]
    [Authorize(Roles = "admin")]
    public async Task<IActionResult> GetAllAppointments()
    {
        var appointments = await _service.GetAllAppointments();
        return Ok(appointments);
    }
}
