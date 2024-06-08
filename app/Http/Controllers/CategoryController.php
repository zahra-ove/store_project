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

    public function store(storeCategoryRequest $request, CategoryResource $categoryResource)
    {
        $category = Category::create($request->validated());
        return $categoryResource->make($category);
    }

    public function show(int $id, CategoryResource $categoryResource)
    {
        $category = Category::findOrFail($id);
        return $categoryResource->make($category);
    }

    public function update(updateCategoryRequest $request, int $id, CategoryResource $categoryResource)
    {
        $validated = $request->validated();
        $category = Category::findOrFail($id)->update($validated);
        return $categoryResource->make($category>refresh());
    }

    public function destroy(int $id)
    {
        Category::where('id', $id)->delete();
        return response()->noContent();
    }
}
