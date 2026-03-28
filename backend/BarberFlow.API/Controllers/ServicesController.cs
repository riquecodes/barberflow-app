using Microsoft.AspNetCore.Mvc;
using BarberFlow.API.Models;
using BarberFlow.API.Services;

namespace BarberFlow.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ServicesController(ServicesService accountService) : ControllerBase
    {
        private readonly ServicesService _accountService = accountService;

        [HttpGet("services/{id}")]
        public async Task<ActionResult<ServiceModel>> GetAccountById(int id)
        {
            var account = await _accountService.GetAccountById(id);

            return Ok(account);
        }

        [HttpGet("{id}/balance")]
        public async Task<ActionResult<decimal>> GetBalanceById(int id)
        {
            var balance = await _accountService.GetBalanceById(id);

            return Ok(balance);
        }

        [HttpPost]
        public async Task<ActionResult<ServiceModel>> CreateService([FromBody] ServiceModel account)
        {
            var newAccount = await _accountService.CreateAccount(account);

            return CreatedAtAction(
                nameof(GetAccountById), 
                new { id = newAccount.Id },
                newAccount);
        }
    }
}
