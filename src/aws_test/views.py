from django.http import HttpResponse


def home(request):
    return HttpResponse("<h1>Home Page Testing 3</h1>")
