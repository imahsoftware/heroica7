class Personastrapractica < ActiveRecord::Base
  belongs_to :personastramite
  belongs_to :user

  validates_inclusion_of :inspeva_dato2,:inspeva_dato3,:inspeva_dato4,:inspeva_dato5,:inspeva_dato6,:inspeva_dato7,:inspeva_dato8,:inspeva_dato9,:inspeva_dato10,:inspeva_dato11,
                         :compeva_dato1,:compeva_dato2,:compeva_dato3,:compeva_dato4,:compeva_dato5,:compeva_dato6,:compeva_dato7,:compeva_dato8,:compeva_dato9,:compeva_dato10,
                         :desteva_dato8,:desteva_dato14, :in => 1..10, :message => "** Error", :on => :update

  validates_inclusion_of :desteva_dato1,:desteva_dato3,:desteva_dato4,:desteva_dato5,:desteva_dato6,:desteva_dato7,:desteva_dato12,:desteva_dato13, :in => 1..6, :message => "** Error", :on => :update

  validates_inclusion_of :desteva_dato2,:desteva_dato9,:desteva_dato10,:desteva_dato11, :in => 1..8, :message => "** Error", :on => :update

  def before_save
    self.cal_inspeccion = (self.inspeva_dato11.to_f + self.inspeva_dato2.to_f + self.inspeva_dato3.to_f + self.inspeva_dato4.to_f + self.inspeva_dato5.to_f + self.inspeva_dato6.to_f + self.inspeva_dato7.to_f + self.inspeva_dato8.to_f + self.inspeva_dato9.to_f + self.inspeva_dato10.to_f)
    self.punt_inspeccion = (self.inspcal_dato11.to_f + self.inspcal_dato2.to_f + self.inspcal_dato3.to_f + self.inspcal_dato4.to_f + self.inspcal_dato5.to_f + self.inspcal_dato6.to_f + self.inspcal_dato7.to_f + self.inspcal_dato8.to_f + self.inspcal_dato9.to_f + self.inspcal_dato10.to_f)
    self.cal_destreza = (self.desteva_dato1.to_f + self.desteva_dato2.to_f + self.desteva_dato3.to_f + self.desteva_dato4.to_f + self.desteva_dato5.to_f + self.desteva_dato6.to_f + self.desteva_dato7.to_f + self.desteva_dato8.to_f + self.desteva_dato9.to_f + self.desteva_dato10.to_f + self.desteva_dato11.to_f + self.desteva_dato12.to_f + self.desteva_dato13.to_f + self.desteva_dato14.to_f)
    self.punt_destreza = (self.destcal_dato1.to_f + self.destcal_dato2.to_f + self.destcal_dato3.to_f + self.destcal_dato4.to_f + self.destcal_dato5.to_f + self.destcal_dato6.to_f + self.destcal_dato7.to_f + self.destcal_dato8.to_f + self.destcal_dato9.to_f + self.destcal_dato10.to_f + self.destcal_dato11.to_f + self.destcal_dato12.to_f + self.destcal_dato13.to_f + self.destcal_dato14.to_f)
    self.cal_comportamiento = (self.compeva_dato1.to_f + self.compeva_dato2.to_f + self.compeva_dato3.to_f + self.compeva_dato4.to_f + self.compeva_dato5.to_f + self.compeva_dato6.to_f + self.compeva_dato7.to_f + self.compeva_dato8.to_f + self.compeva_dato9.to_f + self.compeva_dato10.to_f)
    self.punt_comportamiento = (self.compcal_dato1.to_f + self.compcal_dato2.to_f + self.compcal_dato3.to_f + self.compcal_dato4.to_f + self.compcal_dato5.to_f + self.compcal_dato6.to_f + self.compcal_dato7.to_f + self.compcal_dato8.to_f + self.compcal_dato9.to_f + self.compcal_dato10.to_f)
    self.calificacion = (self.cal_inspeccion.to_f + self.cal_destreza.to_f + self.cal_comportamiento.to_f)
    self.puntaje = (self.punt_inspeccion.to_f + self.punt_destreza.to_f + self.punt_comportamiento.to_f)
  end

end





