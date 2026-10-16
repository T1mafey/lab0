#!/bin/bash

echo "== Часть 1 =="
mkdir -p ~/lab0/claude_monet/kitchen/hot_station \
         ~/lab0/claude_monet/kitchen/cold_station \
         ~/lab0/claude_monet/freezer \
         ~/lab0/claude_monet/pantry \
         ~/lab0/claude_monet/chef_office \
         ~/lab0/claude_monet/staff_room
cd ~/lab0

git init

git config --global user.email "timachiv@gmail.com"
git config --global user.name "Timachiv"

git branch -m master

cat > claude_monet/kitchen/hot_station/senya_inventory << 'EOF'
Говядина для фирменного блюда получена
Сеня проверил мясо перед сменой
Одна упаковка колбасок оставлена на завтра
EOF

cat > claude_monet/kitchen/hot_station/meat_order << 'EOF'
Телятина для шефа
Фарш для котлет
Курица для банкета
Заказ должен принять Сеня
EOF

cat > claude_monet/kitchen/cold_station/fedya_inventory << 'EOF'
Сибас доставлен утром
Федя проверил рыбный холодильник
Дорадо осталось четыре штуки
EOF

cat > claude_monet/kitchen/cold_station/fish_order << 'EOF'
Лосось для холодной закуски
Тунец для специального заказа
Рыбные продукты передать Феде
EOF

cat > claude_monet/freezer/reserve_list << 'EOF'
Две утки для блюда Баринова
Коробка замороженных овощей
Запас мяса для большой компании
EOF

cat > claude_monet/pantry/missing_products << 'EOF'
Пропала упаковка дорогих колбасок
Не найден сыр из новой поставки
Сеня и Федя обещали всё объяснить
Баринов требует отчёт до открытия
EOF

cat > claude_monet/chef_office/barinov_report << 'EOF'
Сеня снова устроил розыгрыш на кухне
Федя помог спрятать продукты
Лёва должен проверить оба цеха
Шеф ждёт объяснительные после смены
EOF

cat > claude_monet/staff_room/prank_plan << 'EOF'
Переставить коробки в кладовой
Сказать Лёве что поставку отменили
Успеть всё вернуть до прихода Баринова
EOF

cat > claude_monet/staff_room/leva_warning << 'EOF'
Лёва заметил беспорядок в кладовой
Записи с кухни переданы шефу
Сеня и Федя останутся после смены
EOF

cat > evening_incident << 'EOF'
Вечерняя смена началась спокойно
На кухне обнаружилась пропажа продуктов
Баринов вызвал Сеню и Федю в кабинет
EOF

chmod 750 claude_monet/kitchen
chmod 640 claude_monet/kitchen/hot_station/senya_inventory
chmod 750 claude_monet/kitchen/cold_station
chmod 644 claude_monet/kitchen/cold_station/fish_order
chmod 600 claude_monet/freezer/reserve_list
chmod 750 claude_monet/pantry
chmod 710 claude_monet/chef_office
chmod 600 claude_monet/staff_room/prank_plan
chmod 644 evening_incident

chmod u=rwx,g=rx,o=rx claude_monet
chmod u=rwx,g=rwx,o=   claude_monet/kitchen/hot_station
chmod u=rw,g=r,o=r     claude_monet/kitchen/hot_station/meat_order
chmod u=rw,g=r,o=      claude_monet/kitchen/cold_station/fedya_inventory
chmod u=rwx,g=rx,o=    claude_monet/freezer
chmod u=rw,g=r,o=      claude_monet/pantry/missing_products
chmod u=r,g=r,o=       claude_monet/chef_office/barinov_report
chmod u=rwx,g=rx,o=    claude_monet/staff_room
chmod u=r,g=r,o=       claude_monet/staff_room/leva_warning

ls -lR ~/lab0

git status
git add .
git commit -m "Solve part 1"


echo "== Часть 2 =="
cp claude_monet/chef_office/barinov_report claude_monet/staff_room/shift_order

cp -r claude_monet/kitchen/cold_station claude_monet/staff_room/cold_backup

ln -s ../pantry/missing_products claude_monet/chef_office/product_loss

ln -s claude_monet/kitchen kitchen_work

ln evening_incident claude_monet/kitchen/incident_copy

cat claude_monet/kitchen/hot_station/senya_inventory \
    claude_monet/kitchen/cold_station/fedya_inventory > claude_monet/kitchen/total_inventory

cat claude_monet/staff_room/leva_warning >> evening_incident

mv claude_monet/staff_room/prank_plan claude_monet/chef_office/senya_explanation

ls -lR ~/lab0

git status
git add .
git commit -m "Solve part 2"

echo "== Часть 3 =="
echo "=== 1 ==="
ls -lR ~/lab0 | grep '^-' | grep -v '_copy$' | sort -k5,5n | tail -n 4

echo "=== 2 ==="
grep -rhi -e 'сеня' -e 'федя' ~/lab0 | grep -v 'Баринов' | sort | head -n 6

echo "=== 3 ==="
grep -rl 'рыб' ~/lab0/claude_monet/kitchen/cold_station \
               ~/lab0/claude_monet/staff_room/cold_backup | wc -l
echo "=== 4 ==="
tail -q -n 2 ~/lab0/claude_monet/kitchen/hot_station/*_inventory \
             ~/lab0/claude_monet/kitchen/cold_station/*_inventory \
  | grep -i -e 'проверил' -e 'оста' | sort -r

echo "=== 5 ==="
grep -v -e 'Сеня' -e 'Федя' ~/lab0/claude_monet/kitchen/total_inventory \
  | sort -r | head -n 3 | wc -w

echo "=== 6 ==="
ls -lR ~/lab0 | grep '^l' | sort -k9,9r

echo "=== 7 ==="
grep -hi -e 'кух' -e 'шеф' \
     ~/lab0/claude_monet/chef_office/barinov_report \
     ~/lab0/claude_monet/staff_room/shift_order \
     ~/lab0/claude_monet/staff_room/leva_warning \
  | grep -v 'после' | sort -r | wc -w

echo "== Часть 4 =="
cd ~/lab0
rm -f claude_monet/chef_office/barinov_report
rm claude_monet/chef_office/product_loss
rm kitchen_work
rm evening_incident
rm claude_monet/kitchen/incident_copy
rm claude_monet/freezer/reserve_list
rmdir claude_monet/freezer
rm -r claude_monet/staff_room/cold_backup

ls -lR ~/lab0

git status
git add .
git commit -m "Solve part 4"

git remote add origin https://github.com/T1mafey/lab0

git push -u origin master
