namespace BarberFlow.Domain.ServicesItems;

public class Services
{
    public int ServiceId { get; set; }

    public string? Name { get; set; }

    public decimal Price { get; set; }

    public string? Description { get; set; }

    public TimeOnly Duration { get; set; }
}
