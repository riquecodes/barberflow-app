namespace BarberFlow.API.Models;

public class TimeSlotModel
{
    public int Id { get; set; }

    public TimeSpan Time { get; set; } // Ex: 09:00, 09:30
}
//TODO: DELETAR

//# horarios(id, id_servico, id_usuario, horario, disponivel)
//# create table horarios (
//# id_horario INT auto_increment PRIMARY KEY,
//# id_service INT NOT NULL,
//# id_user INT NOT NULL,
//# dia DATE NOT NULL,
//# horario TIME NOT NULL,
//#    
//# FOREIGN KEY (id_service) REFERENCES services(id_service),
//# FOREIGN KEY (id_user) REFERENCES users(id_user)
//#)
