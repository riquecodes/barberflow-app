using Microsoft.AspNetCore.Mvc;

namespace BarberFlow.API.Controllers;

[ApiController]
[Route("barber/auth")]
public class AuthController(IAuthService authService) : ControllerBase
{
    private readonly IAuthService _authService = authService;

    [Route("login")]
    [HttpPost]
    public async Task<IActionResult> Login(LoginCommand loginCommand)
    {
        return Ok();
    }

    [Route("register")]
    [HttpPost]
    public async Task<IActionResult> Register(RegisterCommand registerCommand)
    {
        return Ok();
    }

    [Route("logout")]
    [HttpPost]
    public async Task<IActionResult> Logout(LogoutCommand logoutCommand)
    {
        return Ok();
    }
}
