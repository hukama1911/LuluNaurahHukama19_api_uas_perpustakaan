<?php

namespace App\Http\Controllers;

use App\Models\Perpustakaan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PerpustakaanController extends Controller
{
    public function index()
    {
        return response()->json(Perpustakaan::all());
    }

    public function show($id)
    {
        $data = Perpustakaan::find($id);
        if (!$data) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }
        return response()->json($data);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_perpustakaan' => 'required',
            'alamat' => 'required',
            'no_telepon' => 'required',
            'tipe' => 'required|in:Negeri,Swasta',
            'latitude' => 'required',
            'longitude' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $data = Perpustakaan::create($request->all());
        return response()->json($data, 201);
    }

    public function update(Request $request, $id)
    {
        $data = Perpustakaan::find($id);
        if (!$data) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        $data->update($request->all());
        return response()->json($data);
    }

    public function destroy($id)
    {
        $data = Perpustakaan::find($id);
        if (!$data) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        $data->delete();
        return response()->json(['message' => 'Data berhasil dihapus']);
    }
}
