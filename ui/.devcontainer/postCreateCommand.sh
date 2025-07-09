#!/bin/sh

# Create a Next.js app
npx create-next-app@latest app --use-yarn --eslint --tailwind --typescript --eslint --no-src-dir

# Change directory to the app
cd app

# Install Tailwind CSS
yarn add -D tailwindcss postcss autoprefixer

# Initialize Tailwind CSS
npx tailwindcss init -p

# Create Tailwind CSS configuration files
echo "module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}" > tailwind.config.js

echo "module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}" > postcss.config.js

# Add Tailwind CSS directives to the global CSS file
mkdir -p styles
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > styles/globals.css

# Update the main application file to include Tailwind CSS
echo "import '../styles/globals.css';

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />
}

export default MyApp;" > pages/_app.js
# Create a simple index page
echo "export default function Home() {
  return (
    <div className='flex items-center justify-center h-screen bg-gray-100'>
      <h1 className='text-4xl font-bold text-blue-600'>Welcome to Next.js with Tailwind CSS!</h1>
    </div>
  );
}" > pages/index.js

# Install ESLint and Prettier
yarn add -D eslint prettier eslint-config-prettier eslint-plugin-prettier

# Create ESLint configuration file
echo "{
    \"extends\": [
        \"next/core-web-vitals\",
        \"plugin:prettier/recommended\"
    ],
    \"rules\": {
        \"prettier/prettier\": [\"error\", {
            \"endOfLine\": \"auto\"
        }]
    }
}" > .eslintrc.json

# Create Prettier configuration file
echo "{
    \"singleQuote\": true,
    \"trailingComma\": \"es5\",
    \"printWidth\": 80,
    \"tabWidth\": 2,
    \"semi\": true
}" > .prettierrc.json

# Install Husky for Git hooks
yarn add -D husky

# Initialize Husky
npx husky install

# Add pre-commit hook to run ESLint and Prettier
npx husky add .husky/pre-commit "yarn lint && yarn format"

# Add scripts to package.json
sed -i '/"scripts": {/a \
    "lint": "eslint . --ext .js,.jsx,.ts,.tsx",\
    "format": "prettier --write .",\
    "prepare": "husky install"\
' package.json

# Install dependencies
yarn install

# Clean up
rm -rf .git