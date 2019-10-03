<?php

namespace App\Exports;

use App\ProjectUnitType;
use Maatwebsite\Excel\Concerns\FromCollection;

class UnitExport implements FromCollection
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return ProjectUnitType::all();
    }

    public function export( $data )
    {
      return $data;
    }
}
