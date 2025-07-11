<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Perpustakaan extends Model
{
    protected $fillable = [
        'nama_perpustakaan',
        'alamat',
        'no_telepon',
        'tipe',
        'latitude',
        'longitude'
    ];
}
