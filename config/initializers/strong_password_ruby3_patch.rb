# frozen_string_literal: true

# strong_password <= 0.0.9 calls errors.add(attr, type, options_hash) — breaks Ruby 3.
# errors.add expects keyword options, not 3rd positional hash.
Rails.application.config.to_prepare do
  next unless defined?(ActiveModel::Validations::PasswordStrengthValidator)

  ActiveModel::Validations::PasswordStrengthValidator.class_eval do
    def validate_each(object, attribute, value)
      ps = ::StrongPassword::StrengthChecker.new(**strength_options(options, object))
      return if ps.is_strong?(value.to_s)

      object.errors.add(attribute, :'password.password_strength', value: value.to_s)
    end
  end
end
