import axios from 'axios'

export default axios.create({
  baseURL: 'https://k10e205.p.ssafy.io',
  headers: {
    'Content-Type': 'application/json'
  },
  withCredentials: true
})
