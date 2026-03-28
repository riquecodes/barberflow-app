using Microsoft.AspNetCore.Mvc;
using BarberFlow.API.Models;
using BarberFlow.API.Services;

namespace BarberFlow.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ServicesController(IAccountService accountService) : ControllerBase
    {
        private readonly IAccountService _accountService = accountService;

        [HttpGet("services/{id}")]
        public async Task<ActionResult<AccountModel>> GetAccountById(int id)
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
        public async Task<ActionResult<AccountModel>> CreateService([FromBody] AccountModel account)
        {
            var newAccount = await _accountService.CreateAccount(account);

            return CreatedAtAction(
                nameof(GetAccountById), 
                new { id = newAccount.Id },
                newAccount);
        }
    }
}
