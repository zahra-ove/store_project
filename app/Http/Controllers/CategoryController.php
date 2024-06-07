<?php

namespace App\Http\Controllers;

use App\Http\Requests\storeCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use App\Models\fs;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return CategoryResource::collection(Category::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(storeCategoryRequest $request, CategoryResource $categoryResource)
    {
        $category = Category::create($request->validated());
        return $categoryResource->make($category);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $category = Category::findOrFail($id);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Category $category)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category)
    {
        //
    }
}
