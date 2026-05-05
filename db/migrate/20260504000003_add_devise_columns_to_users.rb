class AddDeviseColumnsToUsers < ActiveRecord::Migration[7.0]
  def up
    # Trackable
    add_column :users, :sign_in_count,       :integer,  default: 0, null: false unless column_exists?(:users, :sign_in_count)
    add_column :users, :current_sign_in_at,  :datetime                          unless column_exists?(:users, :current_sign_in_at)
    add_column :users, :last_sign_in_at,     :datetime                          unless column_exists?(:users, :last_sign_in_at)
    add_column :users, :current_sign_in_ip,  :string                            unless column_exists?(:users, :current_sign_in_ip)
    add_column :users, :last_sign_in_ip,     :string                            unless column_exists?(:users, :last_sign_in_ip)

    # Recoverable
    add_column :users, :reset_password_token,   :string   unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)

    # Rememberable
    add_column :users, :remember_created_at, :datetime unless column_exists?(:users, :remember_created_at)

    # Lockable (unlock_token ya puede existir)
    add_column :users, :unlock_token, :string unless column_exists?(:users, :unlock_token)

    # Two-factor (devise-two-factor)
    add_column :users, :encrypted_otp_secret,      :string  unless column_exists?(:users, :encrypted_otp_secret)
    add_column :users, :encrypted_otp_secret_iv,   :string  unless column_exists?(:users, :encrypted_otp_secret_iv)
    add_column :users, :encrypted_otp_secret_salt, :string  unless column_exists?(:users, :encrypted_otp_secret_salt)
    add_column :users, :consumed_timestep,         :integer unless column_exists?(:users, :consumed_timestep)
    add_column :users, :unconfirmed_otp_secret,    :string  unless column_exists?(:users, :unconfirmed_otp_secret)

    # Campos de negocio usados en controllers/helpers
    add_column :users, :activo,                :string   unless column_exists?(:users, :activo)
    add_column :users, :geintac,               :string   unless column_exists?(:users, :geintac)
    add_column :users, :tipoconsulta,          :string   unless column_exists?(:users, :tipoconsulta)
    add_column :users, :tipoconsulta2,         :string   unless column_exists?(:users, :tipoconsulta2)
    add_column :users, :tipoconsultatmp,       :string   unless column_exists?(:users, :tipoconsultatmp)
    add_column :users, :ingresoseguro,         :string   unless column_exists?(:users, :ingresoseguro)
    add_column :users, :etapa,                 :string   unless column_exists?(:users, :etapa)
    add_column :users, :persona_id,            :integer  unless column_exists?(:users, :persona_id)
    add_column :users, :portafolio_id,         :integer  unless column_exists?(:users, :portafolio_id)
    add_column :users, :portafoliossucursal_id,:integer  unless column_exists?(:users, :portafoliossucursal_id)
    add_column :users, :portafolioscargo_id,   :integer  unless column_exists?(:users, :portafolioscargo_id)
    add_column :users, :municipio_id,          :integer  unless column_exists?(:users, :municipio_id)
    add_column :users, :centro_id,             :integer  unless column_exists?(:users, :centro_id)
    add_column :users, :cargo_id,              :integer  unless column_exists?(:users, :cargo_id)
    add_column :users, :user2_id,              :integer  unless column_exists?(:users, :user2_id)
    add_column :users, :cohorte_id,            :integer  unless column_exists?(:users, :cohorte_id)
    add_column :users, :observaciones,         :string   unless column_exists?(:users, :observaciones)
    add_column :users, :celular,               :string   unless column_exists?(:users, :celular)
    add_column :users, :telefonos,             :string   unless column_exists?(:users, :telefonos)
    add_column :users, :direccion,             :string   unless column_exists?(:users, :direccion)
    add_column :users, :genero,                :string   unless column_exists?(:users, :genero)
    add_column :users, :hometab,               :string   unless column_exists?(:users, :hometab)
    add_column :users, :estapaedu,             :string   unless column_exists?(:users, :estapaedu)
    add_column :users, :autotratamiento_fecha, :datetime unless column_exists?(:users, :autotratamiento_fecha)
    add_column :users, :autotratamiento_ip,    :string   unless column_exists?(:users, :autotratamiento_ip)
    add_column :users, :unique_session_id,     :string   unless column_exists?(:users, :unique_session_id)
    add_column :users, :dashboard,             :string   unless column_exists?(:users, :dashboard)
    add_column :users, :directivo,             :string   unless column_exists?(:users, :directivo)
    add_column :users, :nro_cuenta,            :string   unless column_exists?(:users, :nro_cuenta)
    add_column :users, :tipo_cuenta,           :string   unless column_exists?(:users, :tipo_cuenta)
    add_column :users, :banco,                 :string   unless column_exists?(:users, :banco)
    add_column :users, :salario,               :integer  unless column_exists?(:users, :salario)
    add_column :users, :fecha_nacimiento,      :date     unless column_exists?(:users, :fecha_nacimiento)
    add_column :users, :avatar_file_name,      :string   unless column_exists?(:users, :avatar_file_name)
    add_column :users, :avatar_content_type,   :string   unless column_exists?(:users, :avatar_content_type)
    add_column :users, :avatar_file_size,      :integer  unless column_exists?(:users, :avatar_file_size)
    add_column :users, :avatar_updated_at,     :datetime unless column_exists?(:users, :avatar_updated_at)

    # Índices
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    add_index :users, :unlock_token,         unique: true unless index_exists?(:users, :unlock_token)
  end

  def down
    remove_column :users, :sign_in_count       if column_exists?(:users, :sign_in_count)
    remove_column :users, :current_sign_in_at  if column_exists?(:users, :current_sign_in_at)
    remove_column :users, :last_sign_in_at     if column_exists?(:users, :last_sign_in_at)
    remove_column :users, :current_sign_in_ip  if column_exists?(:users, :current_sign_in_ip)
    remove_column :users, :last_sign_in_ip     if column_exists?(:users, :last_sign_in_ip)
    remove_column :users, :reset_password_token   if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
    remove_column :users, :unlock_token        if column_exists?(:users, :unlock_token)
  end
end
