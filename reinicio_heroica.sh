#!/bin/bash

export RAILS_ENV=production
APP_DIR="/home/deploy/Heroica"
cd $APP_DIR

echo ">>> [1/4] Actualizando código..."
git pull origin dev

echo ">>> [2/4] Instalando gemas..."
bundle install --quiet 2>&1 | grep -v "warning:"

echo ">>> [3/4] Precompilando assets..."
bundle exec rake assets:precompile 2>&1 | grep -v "warning:"

echo ">>> [4/4] Reiniciando Puma..."
sudo systemctl restart puma_heroica

echo "✓ Heroica reiniciada correctamente"
