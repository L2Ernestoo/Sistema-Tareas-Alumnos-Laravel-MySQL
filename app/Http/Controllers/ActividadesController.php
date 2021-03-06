<?php

namespace App\Http\Controllers;

use App\actividades;
use App\entregas;
use App\grados;
use App\materias;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class ActividadesController extends Controller
{
    public function index(){
        $materias = materias::all();
        $grados = grados::all();

        return view('catedraticos.actividades.index', compact('materias', 'grados'));
    }

    public function all(){
        if(Auth::user()->roles_id_rol === 1) {
            $actividades = actividades::where('id_docente', Auth::user()->id)
                ->join('materias', 'actividades.id_materia', '=', 'materias.id_materia')
                ->join('grados', 'actividades.grados_id_grado', '=', 'grados.id_grado')
                ->select('actividades.*', 'grados.descripcion as grado', 'materias.descripcion as materia')
                ->get();
        }else{
            $actividades = actividades::join('materias', 'actividades.id_materia', '=', 'materias.id_materia')
                ->join('grados', 'actividades.grados_id_grado', '=', 'grados.id_grado')
                ->join('users', 'actividades.id_docente', '=', 'users.id')
                ->select('actividades.*', 'grados.descripcion as grado', 'materias.descripcion as materia','users.name as catedratico')
                ->get();
        }
        return view('catedraticos.actividades.all', compact('actividades'));
    }

    public function store(Request $request){

        $request->validate([
            'materia' => 'required',
            'grado' => 'required',
            'g-recaptcha-response' => 'recaptcha',
        ]);


        $file = $request->file('file');
        $archivopath = $this->uploadFile($file,'archivo');
        $actividad = new actividades;
        $actividad->descripcion = $request->descripcion;
        $actividad->url_actividad = $archivopath;
        $actividad->id_docente = Auth::user()->id;
        $actividad->id_materia = $request->materia;
        $actividad->grados_id_grado = $request->grado;
        $actividad->save();

        return redirect()->route('actividades.index');
    }

    function uploadFile($file, $dir)
    {
        $now = time();
        $tiempo = date('Y/m', $now);
        $fileName = '/' . $dir . '/' . $tiempo;
        return Storage::disk('local')->put($fileName, $file, 'public');
    }

    public function subirTarea(){
        return view('alumnos.tarea');
    }

    public function tarea(Request $request){

        $request->validate([
            'g-recaptcha-response' => 'recaptcha',
        ]);


        $file = $request->file('file');
        $archivopath = $this->uploadFile($file,'tarea');

        $tarea = new entregas;
        $tarea->descripcion = $request->descripcion;
        $tarea->url_entrega = $archivopath;
        $tarea->users_id = Auth::user()->id;
        $tarea->save();

        return redirect()->route('actividades.index');
    }

    public function tareas(){
        if(Auth::user()->roles_id_rol === 1) {
            $tareas = entregas::join('users', 'entregas.users_id', '=', 'users.id')
                ->select('entregas.*', 'users.name as alumno')
                ->get();
        }else{
            $tareas = entregas::where('users_id', Auth::user()->id)
                ->get();
        }
        return view('alumnos.all', compact('tareas'));
    }
}
