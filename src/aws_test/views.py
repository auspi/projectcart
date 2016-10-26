from django.http import HttpResponse


def home(request):
    return HttpResponse("I am a simple man, I see you, I like it")
