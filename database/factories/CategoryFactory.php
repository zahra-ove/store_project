<?php

namespace Database\Factories;

use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
 */
class CategoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->word(),
            'category_id' => $this->faker->randomElement(Category::pluck('id')),
        ];
    }


    public function maincategory()
    {
        return $this->state(function (array $attributes){
            return [
                'category_id' => null
            ];
        });
    }
}
