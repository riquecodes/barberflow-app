using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using BarberFlow.API.Services;
using BarberFlow.API.Models;

namespace BarberFlow.API.Controllers;

[ApiController]
[Route("barber/auth")]
public class AuthController(IAuthService authService) : ControllerBase
{
    private readonly IAuthService _authService = authService;

    [HttpPost("login")]
    public async Task<ActionResult<AuthResponseDTO>> Login([FromBody] LoginDTO loginDTO)
    {
        var authResponse = await _authService.Login(loginDTO);

        return Ok(authResponse);
    }

    [HttpPost("register")]
    public async Task<ActionResult<UserResponseDTO>> Register([FromBody] RegisterDTO userRegister)
    {
        var registerResponse = await _authService.Register(userRegister);
        return Ok(registerResponse);
    }

    [Authorize]
    [HttpPost("change-password")]
    public async Task<ActionResult> ChangePassword([FromBody] ChangePasswordDTO changePasswordDTO)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        await _authService.ChangePassword(userId, changePasswordDTO.CurrentPassword, changePasswordDTO.NewPassword);
        return Ok(new { message = "Password updated successfully!" });
    }
}
