<?php

namespace App\Http\Controllers;

use App\Http\Requests\storeCategoryRequest;
use App\Http\Requests\updateCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;

class CategoryController extends Controller
{
    public function index()
    {
        return CategoryResource::collection(Category::all());
    }

    public function store(storeCategoryRequest $request)
    {
        $category = Category::create($request->validated());
        return new CategoryResource($category);
    }

    public function show(int $id)
    {
        $category = Category::findOrFail($id);
        return new CategoryResource($category);
    }

    public function update(updateCategoryRequest $request, int $id)
    {
        $validated = $request->validated();
        $category = Category::findOrFail($id);
        $category->update($validated);
        return new CategoryResource($category->refresh());
    }

    public function destroy(int $id)
    {
        Category::where('id', $id)->delete();
        return response()->noContent();
    }
}
