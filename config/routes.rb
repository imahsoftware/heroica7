Rails.application.routes.draw do

  # ─── Errores ────────────────────────────────────────────────────────────────
  get  'errors/not_found'
  get  'errors/internal_server_error'
  match '/404', to: 'errors#not_found',             via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # ─── Raíz según autenticación ───────────────────────────────────────────────
  authenticated :user do
    root 'menus#index', as: :authenticated_root
  end

  root 'home#index'

  # ─── Autenticación (Devise) ──────────────────────────────────────────────────
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users_controller'
  }

  devise_scope :user do
    scope :users, as: :users do
      get 'pre_otp',  to: 'users/sessions#pre_otp'
      get 'iniciar',  to: 'users/sessions#iniciar'
    end

    post '/users/sessions/verify_otp' => 'users/sessions#verify_otp'

    put    'users'      => 'devise/registrations#update',  as: 'user_registration'
    get    'users/edit' => 'devise/registrations#edit',    as: 'edit_user_registration'
    delete 'users'      => 'devise/registrations#destroy', as: 'registration'
    get    'logout'     => 'devise/sessions#destroy'
  end

  # ─── Menú / Home ────────────────────────────────────────────────────────────
  resources :menus, only: [:index] do
    collection do
      get  'menu'
      get  'control_firma_digital'
      post 'captura_rostro'
      get  'aceptartratamiento'
      get  'tratamientodatos'
      get  'runjob'
      get  'searchall'
      post :index
      post 'cargarprueba'
      get  'semaforoalertas'
      get  'abrirmapa'
      get  'modogestion'
      get  'call'
      get  'disconect'
      get  'produccion'
      get  'parametros'
      get  'programaexamenteo'
      get  'libranzas'
      post 'filtroedu'
      post 'filtrocredito2'
      get  'recaudo_detalle_dia'
      post 'filtrosistem'
      get  :autocomplete_persona_nombre
    end
  end

  # ─── Admin ──────────────────────────────────────────────────────────────────
  scope '/admin' do

    resources :audits, only: [:index, :show] do
      collection do
        get 'busqueda'
      end
    end

    resources :users do
      collection do
        get  :autocomplete_identificacion_nombre
        get  :autocomplete_cambio_user2
        get  :autocomplete_user_nombre
        get  'tabhome'
        get  'resetpass'
        get  'reestablecesusuario'
        get  'cambiousuario'
        get  'cargar'
        get  'cargar2'
        get  'inconsistencias'
        get  'fincargue'
        get  'actemail'
        post 'updateemailedu'
        get  'modogestion'
        get  'modograficoedu'
        get  'desbloquearusuariof'
        get  'desbloquearusuario'
        get  'desbloquearusuariop'
        get  'activaruser'
        get  'inactivaruser'
        get  'cambioportafolio'
        get  'cambiotipoconsulta'
        get  'cambiosucursal'
        get  'cambiarperfil'
        get  'masivo'
        get  'updatepass'
        post 'etapar'
        get  'etapa'
        get  'act'
        get  'edupol_desbloquearusuario'
        get  'carguemasivo'
        post 'importar'
        post 'importar2'
        get  'permisosymodulos'
        get  'activarinactivar'
      end

      resources :usersmodulos,    only: [:index, :show, :new, :edit, :create, :update, :destroy]
      resources :userspermisos,   only: [:show, :new, :edit, :create, :update, :destroy]
      resources :usersreportes,   only: [:show, :new, :edit, :create, :update, :destroy]
      resources :usersimagenes,   only: [:index, :show, :new, :edit, :create, :update, :destroy]
    end

  end

  # ─── Módulos de seguridad ────────────────────────────────────────────────────
  resources :usersmodulos, only: [] do
    collection do
      get :menu
      get :datos
      get :aprobarterminos
    end
  end

  resources :modulos
  resources :objetos
  resources :parametros
  resources :portafolios do
    resources :portafoliospersonas, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  end

  resources :permisos do
    member do
      get  'asignar'
    end
    collection do
      post 'asignacion'
    end
  end

  resources :grupos
  resources :productos
  resources :placas
  resources :empresas do
    collection do
      post 'add_empresa'
    end
  end

  resources :egresos do
    collection do
      get  'buscar'
      get  'busqueda'
      post 'add_egreso'
    end
    resources :egresosimagenes, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  end

  resources :tiposcombustibles
  resources :instructores
  resources :categorias
  resources :tipostramites

  resources :compras do
    resources :comprasdetalles
  end

  resources :conceptos
  resources :cobrostramites
  resources :proveedores
  resources :empleados



  # ─── Personastramiteshoras ──────────────────────────────────────────────────
  resources :personastramiteshoras, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
    collection do
      get  'hora'
      get  'new2'
      post 'create2'
      get  'update2'
    end
  end

  # ─── Facturas ────────────────────────────────────────────────────────────────
  resources :facturas, only: [:index, :show, :edit, :update] do
    collection do
      get  'busqueda'
      get  'buscar'
      get  'verfactura'
      get  'informeclases'
    end
  end

  # ─── Personas ───────────────────────────────────────────────────────────────
  resources :personas, only: [:new, :create, :edit, :update, :destroy] do
    collection do
      get  'busqueda'
      get  'buscar'
      get  'listar'
      get  'informesiet'
      get  'informeper'
    end
    resources :personastramites, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      member do
        get  'registroclase'
        get  'registrosolicitud'
        get  'diploma'
        get  'acuerdocomercial'
        get  'teorico'
        get  'crearfactura'
        get  'practica'
        get  'practicam'
      end
    end
    resources :personasclases, only: [:index, :show, :new, :edit, :create, :update, :destroy]
    resources :teoricos,       only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      member do
        get 'informe'
      end
    end
  end

  # Busqueda global de teoricos (para iniciar prueba)
  get  'teoricos/busqueda', to: 'teoricos#busqueda', as: 'teoricos_busqueda'


end
