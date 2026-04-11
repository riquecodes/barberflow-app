using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using BarberFlow.API.Models;
using BarberFlow.API.Services;

namespace BarberFlow.API.Controllers
{
    [ApiController]
    [Route("barber/users")]
    public class UserController(UserService userService) : ControllerBase
    {
        private readonly UserService _userService = userService;

        [Authorize(Roles = "admin")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserResponseDTO>>> GetUsers()
        {
            var users = await _userService.GetUsers();

            return Ok(users);
        }

        [Authorize(Roles = "admin")]
        [HttpGet("id/{id}")]
        public async Task<ActionResult<UserResponseDTO>> GetUserById(int id)
        {
            var user = await _userService.GetUserById(id);

            return Ok(user);
        }

        [Authorize(Roles = "admin")]
        [HttpPost]
        public async Task<ActionResult<UserResponseDTO>> CreateUser([FromBody] RegisterDTO userRegister)
        {
            var newUser = await _userService.CreateUser(userRegister);

            return CreatedAtAction(
                nameof(GetUserById),
                new { id = newUser.UserId },
                newUser);
        }

        [Authorize(Roles = "admin")]
        [HttpPut("{id}")]
        public async Task<ActionResult<UserResponseDTO>> UpdateUser(int id, [FromBody] UserModelDTO userDTO)
        {
            var updatedUser = await _userService.UpdateUser(id, userDTO);

            return Ok(updatedUser);
        }

        [Authorize(Roles = "admin")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        { 
            await _userService.DeleteUserById(id);

            return NoContent();
        }

        [Authorize]
        [HttpPut("profile/{id}")]
        public async Task<ActionResult<UserResponseDTO>> UpdateProfile(int id, [FromBody] UserModelDTO userDTO)
        {
            var updatedUser = await _userService.UpdateUser(id, userDTO);

            return Ok(updatedUser);
        }
    }
}
