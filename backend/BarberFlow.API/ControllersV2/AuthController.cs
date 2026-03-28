//using BarberFlow.Application.Auth;
//using BarberFlow.Application.AuthItems;
//using BarberFlow.Application.AuthItems.Login;
//using BarberFlow.Domain.UserItems;
//using BarberFlow.API.Services;
//using Microsoft.AspNetCore.Authorization;
//using Microsoft.AspNetCore.Mvc;

//namespace BarberFlow.API.ControllersV2;

//[ApiController]
//[Route("barber/auth")]
//public class AuthController(AuthService authService) : ControllerBase
//{
//    [HttpPost("login")]
//    public async Task<IActionResult> Login(LoginCommand command, CancellationToken cancellationToken)
//    {
//        var response = await authService.LoginAsync(command, cancellationToken);
//        return Ok(response);
//    }

//    [HttpPost("register")]
//    public async Task<IActionResult> Register(RegisterCommand command, CancellationToken cancellationToken)
//    {
//        var response = await authService.RegisterAsync(command, cancellationToken);
//        return CreatedAtAction(nameof(Me), null, response);
//    }

//    [Authorize]
//    [HttpPost("logout")]
//    public async Task<IActionResult> Logout(LogoutCommand command, CancellationToken cancellationToken)
//    {
//        var userId = User.GetUserId();
//        await authService.LogoutAsync(userId, command, cancellationToken);
//        return NoContent();
//    }

//    [Authorize]
//    [HttpGet("me")]
//    public async Task<IActionResult> Me(CancellationToken cancellationToken)
//    {
//        var userId = User.GetUserId();
//        var response = await authService.GetProfileAsync(userId, cancellationToken);
//        return Ok(response);
//    }

//    [Authorize]
//    [HttpPut("me")]
//    public async Task<IActionResult> UpdateProfile(UpdateAccountCommand command, CancellationToken cancellationToken)
//    {
//        var userId = User.GetUserId();
//        var response = await authService.UpdateProfileAsync(userId, command, cancellationToken);
//        return Ok(response);
//    }

//    [Authorize]
//    [HttpPut("me/password")]
//    public async Task<IActionResult> ChangePassword(ChangePasswordCommand command, CancellationToken cancellationToken)
//    {
//        var userId = User.GetUserId();
//        var response = await authService.ChangePasswordAsync(userId, command, cancellationToken);
//        return Ok(response);
//    }

//    [Authorize(Roles = UserRoles.Admin)]
//    [HttpGet("accounts")]
//    public async Task<IActionResult> ListAccounts(CancellationToken cancellationToken)
//    {
//        var response = await authService.GetAccountsAsync(cancellationToken);
//        return Ok(response);
//    }

//    [Authorize(Roles = UserRoles.Admin)]
//    [HttpPut("accounts/{id}/roles")]
//    public async Task<IActionResult> AssignRole(int id, AssignRoleCommand command, CancellationToken cancellationToken)
//    {
//        var response = await authService.AssignRoleAsync(id, command, cancellationToken);
//        return Ok(response);
//    }
//}
//TODO: VERIFICAR
