const std = @import("std");
const zap = @import("zap");

pub const Self = @This();

pub fn create(listener: *zap.Endpoint.Listener, allocator: std.mem.Allocator) !std.ArrayList(*zap.Endpoint) {
    var endpoints = std.ArrayList(*zap.Endpoint).init(allocator);
    errdefer endpoints.deinit();

    const speakersEndpoint = try allocator.create(zap.Endpoint);
    errdefer allocator.destroy(speakersEndpoint);

    speakersEndpoint.* = zap.Endpoint.init(.{
       .path = "/admin/speakers",
       .get = listSpeakers,
    });

    try listener.register(speakersEndpoint);
    try endpoints.append(speakersEndpoint);

    const microphonesEndpoint = try allocator.create(zap.Endpoint);
    errdefer allocator.destroy(microphonesEndpoint);

    microphonesEndpoint.* = zap.Endpoint.init(.{
       .path = "/admin/microphones",
       .get = listMicrophones
    });

    try listener.register(microphonesEndpoint);
    try endpoints.append(microphonesEndpoint);

    return endpoints;
}

fn listSpeakers(e: *zap.Endpoint, r: zap.Request) void {
   _ = e;
   r.sendBody("<html><body><h1>Speakers<h1></body></html>") catch return;
}

fn listMicrophones(_: *zap.Endpoint, r: zap.Request) void {
    r.sendBody("<html><body><h1>Microphones<h1></body></html>") catch return;
}
