// Uniforms:
uniform vec3 light_d;

// Varying attributes:
varying vec3 norm_new;
varying vec3 light_dir;
varying vec3 frag_pos;
varying vec3 camera_pos;

void main() {

  norm_new = normalize(normalMatrix * normal);
  vec4 light_eye = normalize(viewMatrix * vec4(light_d, 0.0));
  light_dir = vec3(light_eye);

  frag_pos = vec3(modelViewMatrix * vec4(position, 1.0));
  camera_pos = vec3(viewMatrix * vec4(cameraPosition, 1.0));

  gl_Position = projectionMatrix * vec4(frag_pos, 1.0);
}