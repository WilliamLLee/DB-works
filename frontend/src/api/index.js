import axios from 'axios'

export const userApi = {
	userList() {
		return axios.get("localhost:3000/login").then((response) => {
			console.log("nnn");
			return response.data;
		})
	}
}
