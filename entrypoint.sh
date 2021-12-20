# while ! nc -z db 3306 ; do
#     echo "Waiting for the MySQL Server"
#     sleep 3
# done

sleep 10

python manage.py migrate --no-input
python manage.py runserver 0.0.0.0:8000
