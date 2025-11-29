/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_BASE_URL: string
  readonly VITE_IMAGE_HOSTNAME: string
  readonly VITE_HOSTNAME: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
