import { defineCollection, z } from 'astro:content';

const projects = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()),
    featured: z.boolean().default(false),
    github: z.string().url().optional(),
    demo: z.string().url().optional(),
    image: z.string().optional(),
    stack: z.array(z.string()),
    status: z.enum(['completed', 'in_progress', 'planned']).default('completed'),
  }),
});

export const collections = { projects };
