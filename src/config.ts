export default {
    api: {
        baseUrl: import.meta.env.VITE_API_BASE_URL || 'https://f365.zyuhel.ru',
    },
    imageHost: {
        domain: import.meta.env.VITE_IMAGE_HOSTNAME || 'http://f365.zyuhel.ru:3000'
    },
    host: {
        domain: import.meta.env.VITE_HOSTNAME || 'http://f365.zyuhel.ru:3000'
    }
};
