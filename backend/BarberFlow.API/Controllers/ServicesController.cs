using Microsoft.AspNetCore.Mvc;
using BarberFlow.API.Models;
using BarberFlow.API.Services;
using Microsoft.AspNetCore.Authorization;

namespace BarberFlow.API.Controllers
{
    [ApiController]
    [Route("barber/services")]
    public class ServicesController(ServicesService servicesService) : ControllerBase
    {
        private readonly ServicesService _servicesService = servicesService;

        [HttpGet("{id}")]
        [Authorize]
        public async Task<ActionResult<ServiceModel>> GetServiceById([FromRoute] int id)
        {
            var account = await _servicesService.GetServiceById(id);

            return Ok(account);
        }

        [HttpGet]
        [Authorize]
        public async Task<ActionResult<IEnumerable<ServiceModel>>> GetAllServices()
        {
            var balance = await _servicesService.GetAllServices();

            return Ok(balance);
        }

        [HttpPost]
        [Authorize(Roles = "admin")]
        public async Task<ActionResult<ServiceModel>> CreateService([FromBody] ServiceModelDTO service)
        {
            var newService = await _servicesService.CreateService(service);

            return CreatedAtAction(
                nameof(GetServiceById), 
                new { id = newService.Id },
                newService);
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "admin")]
        public async Task<ActionResult<ServiceModel>> UpdateService([FromRoute] int id, [FromBody] ServiceModelDTO service)
        {
            var newService = await _servicesService.UpdateService(id, service);

            return CreatedAtAction(
                nameof(GetServiceById),
                new { id = newService.Id },
                newService);
        }
    }
}
