# Generated by Django 5.0.3 on 2024-05-08 19:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('profiles', '0003_friendship_friendrequest_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='uid',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
        migrations.AlterModelTable(
            name='userprofile',
            table='profile',
        ),
    ]